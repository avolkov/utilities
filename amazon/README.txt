My feeble attempt at using amazon services:

	credentials.py -- secret keys
	ec2_connect.py -- a several handy wrappers around boto library. Support shutting down of instances without terminating them. Instance names & instance groups are obviously hardcoded. create_my_instance() spins up 64bit 10.04 LTS.
	fuse_amazon_s3.odt -- instructions on setting up access to S3 using fuse on 10.04 LTS
	run.py -- yet another wrapper, quickly start up hardcoded instance