import paramiko
import StringIO
import boto3

ssm = boto3.client('ssm')

def lambda_handler(event, context):

	# Retrieve SSH key
	parameter_name = event['parameterName']
	response = ssm.get_parameter(Name=parameter_name,WithDecryption=True)
	ssm_key = response['Parameter']['Value']
	pkey = paramiko.RSAKey.from_private_key(StringIO.StringIO(ssm_key))
	
	# Connect to the host
	ssh = paramiko.SSHClient()
	ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

	hostname = event['hostname']
	username = event['username']
	port = event['port']
	ssh.connect(hostname=hostname, port=port, username=username, pkey=pkey)

	# Run command
	command = event['command']
	ssh.exec_command(command)
	ssh.close()

	# Return response
	return {'message': "Command execution completed. See Cloudwatch logs for complete output"}


