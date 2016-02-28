from random import choice
import os
import string
import MySQLdb
def GenPassword(length=8,chars=string.lowercase+string.digits):
    return ''.join([choice(chars) for i in range(length)])

def genPW():

	f = open("./names.txt")
	os.system("touch ./passwd.txt")
	fw = open("./passwd.txt" , 'w')
	lines = f.readlines()
	for line in lines:
		line = line.strip()
		s = line + "##" + (GenPassword(8))
		fw.write(s + "\n")

def insertDB():
	try:
		conn = MySQLdb.connect(host = 'localhost' , user = 'root' , passwd = 'root' , port = 3306 ,charset='utf8')
		cur = conn.cursor()
		conn.select_db('db_test')
		f = open("passwd.txt")
		lines = f.readlines()
		for line in lines:
			line = line.strip()
			studentnum = line.split("##")[0]
			email = line.split("##")[1]
			userType = line.split("##")[2]
			passwd = line.split("##")[3]
			cur.execute("insert into user_table(studentnum , password , email , userType) select '" + studentnum + "','"+ passwd+"' , '" + email +"' , '" + userType+"' from dual where not exists(select studentnum from user_table where studentnum = '"+studentnum+"')")
		conn.commit()
		cur.close()
		conn.close()
	except MySQLdb.Error, e:
		print "Mysql Error %d: %s" % (e.args[0], e.args[1])
if __name__ == '__main__':
	# genPW()
	insertDB()
