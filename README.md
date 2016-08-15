# Matrix Config 
## Configuration files for the matrix. 

### Requirements

These are all ansible scripts and can be run on any server with SSH.

	pip install ansible

For testing we use vagrant to spin up a virtual machine.

	apt get install vagrant
	cd testing && vagrant up

If you make changes to the ansible scripts you can run ```vagrant provision``` to deploy changes. 