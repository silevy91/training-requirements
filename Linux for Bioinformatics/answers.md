Q1: What is your home directory?
Answer: /home/ubuntu

Q2: What is the output of this command (ls in my_folder)?
Answer: hello_world.txt

Q3: What is the output of each ls command?
Answer:
my_folder:
Nothing

my_folder2:
hello_world.txt

Q4: What is the output of each?
Answer:
my_folder:
Nothing

my_folder2:
Nothing

my_folder3:
hello_world.txt

Q5: Why didn't that work?
Answer: There was no key pair available for the new user to connect via ssh.

Q6: What was the solution?
Answer: The public keys that an user is authorized to log in with are stored in $/.ssh/authorized_keys. I created that folder and file in sudouser's home directory and changed 
	permissions for .ssh to 700 (only owner may read, write, and execute) and for .ssh/authorized_keys to 600 (only owner may read and write).  I then retrieved the public key
	for the key pair I had generated when starting the instance from ubuntu/.ssh/authorized_keys. I could have generated a new key pair, but since the user ubuntu will be deleted later, I repurposed
	the key pair. Now, when loggin in via MobaXterm, I can specify sudouser as the username and the .pem file I used previously for ubuntu as the private key and login is successful.

Q7: What does the sudo docker run part of the command do? And what does the salmon swim part of the command do?
Answer: The sudo docker run part of the command looks for the combinelab/salmon image on the local machine. Since we pulled it in the previous command, it will proceed from there.
	Had it not been there, it would have pulled it from Docker. It then creates a new container, where the environment described in the salmon image can run. The salmon swim command then tells
	executes the swim command in the salmon program within the Docker container in the Docker host. The output of this executable, the salmon logo and version info, is then streamed to the console.

Q8: What is the output of this command?
Answer: Serveruser is not in the sudoers file. This incident will be reported.

Q9: What does -c bioconda do?
Answer: It specifies that conda install should look for the salmon package in the bioconda channel. Packages with the same name can exist in multiple channels, and the -c flag allows us to specify which.

Q10: What does the -o athal.fa.gz part of the command do?
Answer: the -o flag specifies a file to direct the output of the curl command to. In this case, we're downloading whole genome information and we want to direct it to a file called "athal" of type fa.gz, which is a compressed FASTA file.

Q11: What is a .gz file?
Answer: It is a compressed archive file.

Q12: What does the zcat command do?
Answer: It unzips the compressed file to access its contents.

Q13: What does the head command do?
Answer: It displays the first lines of the file.

Q14: What does the number 100 signify in the command?
Answer: It specifies the number of lines to display, in this case we want to see the first 100 lines of the athal.fa.gz file.

Q15: What is | doing?
Answer: It is shell's pipe command. It directs the output of the command to the left of the | as input to the command to the right. In this case we 
	unzip the contents of the archive and pipe the output (the unzipped file) as input to the head command to inspect its first 100 lines.

Q16: What format are the downloaded sequencing reads in?
Answer: They are in a .sra file

Q17: What is the total size of the disk?
Answer: 7.7 GB

Q18: How much space is remaining on the disk?
Answer: 3.4 GB

Q19: What went wrong?
Answer: The disk ran out of storage and the fastq-dump was aborted.

Q20: What was your solution?
Answer: add the --gzip flag to the fastq-dump command to make the output archived and save space.
