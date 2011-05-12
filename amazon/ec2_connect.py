#!/usr/bin/python
# -*- coding: utf-8 -*-

import credentials
from boto.ec2.connection import EC2Connection
import boto, boto.ec2


boto.config.add_section('Credentials')
boto.config.set('Credentials', 'aws_access_key_id', credentials.access_key)
boto.config.set('Credentials', 'aws_secret_access_key',credentials.secret_key )


#conn = EC2Connection(credentials.access_key, credentials.secret_key)
connection = None
regions = boto.ec2.regions()
myregion = None
for region in regions:
	if region.name == 'us-east-1':
		myregion = region

connection = myregion.connect()

def get_all_instances():
	group_name = 'quick-start-1'
	quickstart = connection.get_all_security_groups([group_name])[0]
	return quickstart.instances()

def list_running():
	output = []
	for k in get_all_instances():
		if k.state == 'running':
			output.append(k)
	return output
def list_running_dns():
	for k in list_running():
		print k.dns_name

def start_backup_instance():
	group_name = 'quick-start-1'
	instance_name = 'i-9ed064f1'
	my_instance = None

	quickstart = connection.get_all_security_groups([group_name])[0]
	for instance in quickstart.instances():
		print instance.id
		if instance.id == instance_name:
			my_instance = instance

	print "My instance is: ",
	print my_instance
	print "DNS Name :",
	print my_instance.dns_name
	#my_instance.update()
	#if my_instance.state ==
	connection.start_instances([str(my_instance.id)])
def stop_backup_instance():
	stop_instance('i-9ed064f1')
def start_instance(inst_id, group_id):
	my_instance = None

	quickstart = connection.get_all_security_groups([group_id])[0]
	for instance in quickstart.instances():
		if instance.id == inst_id:
			my_instance = instance

			print "My instance is: ",
			print my_instance
			print "DNS Name :",
			print my_instance.dns_name
			#my_instance.update()
			#if my_instance.state ==
			connection.start_instances([str(my_instance.id)])

def create_my_instance():
	ubuntu64_ami = 'ami-3202f25b'
	ubuntu_64_image = connection.get_all_images(ubuntu64_ami)
	reservation = connection.run_instances(
		image_id='ami-3202f25b',
		min_count=1,max_count=1,
		key_name='tutorial',
		security_groups=['quick-start-1'],
		instance_type="t1.micro",
	)


	'''
	connection.run_instances(
		image_id='ami-3202f25b',
		min_count=1,max_count=1,
		key_name='tutorial',
		security_groups=['quick-start-1'],
		instance_type="t1.micro",
		placement="us-east-1"
	)
	'''
def stop_instance(inst_id):
	connection.stop_instances([inst_id])