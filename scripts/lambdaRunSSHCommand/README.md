# runSSHCommand

Lambda function designed to run an SSH command on a remote host

## Input parameters

The function expects a JSON with the following structure as the input ('event' in the code):

```
{
  "parameterName": "my_parameter",
  "hostname": "my_hostname",
  "port": 22,
  "username": "my_username",
  "command": "my_shell_command"
}
```

Each parameter explained:

* parameterName: Name of the AWS Systems Manager parameter stored in Parameter Store that contains the private SSH key to be used to authenticate via SSH.

* hostname: Hostname to connect to.

* port: Port to use in the SSH connection.

* username: Username to connect with.

* command: Shell command to be executed after connecting.

## How to build

Instructions from [here](https://docs.aws.amazon.com/lambda/latest/dg/lambda-python-how-to-create-deployment-package.html#python-package-dependencies):

1. Create a directory

2. Download the 'runSSHCommand.py' file and place it in the directory

3. Run `pip install paramiko --target .` inside the directory

4. Create a ZIP archive: `zip -r9 ../function.zip .`

5. Add the code to the archive: `zip -g ../function.zip runSSHCommand.py`

6. Upload the package to AWS Lambda: `aws lambda update-function-code --function-name <my_function> --zip-file fileb://function.zip`
