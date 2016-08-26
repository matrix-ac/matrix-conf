#!/usr/bin/perl
#
# Set appropriate permissions across your public_html
# directory.
# 
# Directories are given 0755;
# PHP is given 0600;
# everything else gets 0644.

use File::Find;

my @u = getpwuid($<);
die "Who are you?!\n" unless (@u > 0);

my $home = $u[7];

die "You don't have a public_html directory\n" 
	unless (-d "$home/public_html");

my $fixed = 0;
File::Find::find(sub {
	my $name = $File::Find::name;
	my @s = stat($name);
	my $perms = $s[2] & 07777;
	if (-d _)
	{
		&fixperms($name, $perms, 0755);
	}
	elsif ($name =~ /\.(php|php3|php4|phpx)$/)
	{
		&fixperms($name, $perms, 0600);
	}
	else
	{
		&fixperms($name, $perms, 0644);
	}
}, "$home/public_html");

if ($fixed == 0)
{
	print "Permissions all look OK\n";
}
else
{
	printf "\nFixed permissions on %d file%s\n",
		$fixed, $fixed==1 ? "" : "s";
}

sub fixperms
{
	my ($file, $oldperms, $newperms) = @_;
	return if ($oldperms == $newperms);
	printf "Fixing permissions on %s (%04o -> %04o)\n", 
		substr($file, length($home)+1), $oldperms, $newperms;
	chmod($newperms, $file);
	$fixed++;
}
