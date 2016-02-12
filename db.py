import MySQLdb
import time

#workspace = '/Users/Eduardo' # \! pwd

def makeUserTables():
	try:
		conn = MySQLdb.connect(host = 'localhost' , user = 'root' , passwd = 'root' , port = 3306 ,charset='utf8')
		cur = conn.cursor()
		cur.execute('drop database if exists db_test')
		cur.execute('create database if not exists db_test')
		conn.select_db('db_test')
		cur.execute('create table user_table( studentnum varchar(20) , password varchar(30) , email varchar(30) , userType int )')		
		cur.execute("insert into user_table values( 'admin' , 'admin0' , 'admin@163.com' , 2  )")		

		conn.commit()
		cur.close()
		conn.close()
	except MySQLdb.Error, e:
		print "Mysql Error %d: %s" % (e.args[0], e.args[1])

def makeCloseUserTables():
	try:
		conn = MySQLdb.connect(host = 'localhost' , user = 'root' , passwd = 'root' , port = 3306 ,charset='utf8')
		cur = conn.cursor()
		conn.select_db('db_test')
		cur.execute('drop table close_user_table');
		cur.execute('create table if not exists close_user_table(studentnum varchar(20) , closetime varchar(12) )')
		cur.execute("insert into close_user_table values( 'aa' , '2015-12-31' )")
		conn.commit()
		cur.close()
		conn.close()
	except MySQLdb.Error, e:
		print "Mysql Error %d: %s" % (e.args[0], e.args[1])

def makeSeatTables():
	try:
		conn = MySQLdb.connect(host = 'localhost' , user = 'root' , passwd = 'root' , port = 3306 ,charset='utf8')
		cur = conn.cursor()
		cur.execute('drop database if exists seat_db')
		cur.execute('create database if not exists seat_db')
		conn.select_db('seat_db')
		for j in xrange(0 , 7):
			cur.execute('create table seat_table_' + str(j) + '( seatnum int , period0 int , period1 int , period2 int , period3 int , period4 int , ownerPeriod0 varchar(20) , ownerPeriod1 varchar(20) ,ownerPeriod2 varchar(20) ,ownerPeriod3 varchar(20) ,ownerPeriod4 varchar(20) , seatsType int)')
			for k in xrange( 0 , 10):
				cur.execute('insert into seat_table_'+ str(j) + " values('" + str(k) + "', 0 , 0,  0 , 0, 0 , NULL , NULL , NULL , NULL , NULL , '0')")
		conn.commit()
		cur.close()
		conn.close()
	except MySQLdb.Error, e:
		print "Mysql Error %d: %s" % (e.args[0], e.args[1])

def makeSeatTable0Events():
	try:
		conn = MySQLdb.connect(host = 'localhost' , user = 'root' , passwd = 'root' , port = 3306 ,charset='utf8')
		cur = conn.cursor()
		conn.select_db('seat_db')

		for i in xrange(0 , 5):
			time = ""
			time1 = ""
			if i == 0 :
				time = "07"
				time1 = "10"
			if i == 1 : 
				time = "09"
				time1 = "12"
			if i == 2 : 
				time = "12"
				time1 = "15"
			if i == 3 :
				time = "14"
				time1 = "17"
			if i == 4 :
				time = "18"
				time1 = "21"
			cur.execute("drop event if exists timeout_period" + str(i))
			cur.execute("create event timeout_period" + str(i) +" on schedule every 1 minute do update seat_table_0 set period" + str(i) + " = 2 where curtime() > '" + str(time)+":00'")

			cur.execute("drop event if exists timeout_ownerPeriod" + str(i))
			cur.execute("create event timeout_ownerPeriod"+ str(i) + " on schedule every 1 minute do update seat_table_0 set ownerPeriod" + str(i) +" = NULL where curtime() > '" + str(time1) +" :00'")

			
		conn.commit()
		cur.close()
		conn.close()
	except MySQLdb.Error, e:
		print "Mysql Error %d: %s" % (e.args[0], e.args[1])

def dayUpdateEvents():
	try:
		conn = MySQLdb.connect(host = 'localhost' , user = 'root' , passwd = 'root' , port = 3306 ,charset='utf8')
		cur = conn.cursor()
		conn.select_db('seat_db')

		cur.execute("drop event if exists backuptodayevent")
		#cur.execute("create event backuptodayevent on schedule every 1 day starts '2016-02-01 00:00:00' do select * into outfile '"+  workspace + "/sqldatabc/" + time.strftime("%d_%m_%y") + ".log' from seat_table_0")
		

		cur.execute("drop event if exists move0_bcevent")
		cur.execute("create event move0_bcevent on schedule every 1 day starts '2016-02-01 00:00:03' do begin drop table if exists seat_table_backup; create table seat_table_backup( seatnum int , period0 int , period1 int , period2 int , period3 int , period4 int , ownerPeriod0 varchar(20) , ownerPeriod1 varchar(20) ,ownerPeriod2 varchar(20) ,ownerPeriod3 varchar(20) ,ownerPeriod4 varchar(20) , seatsType int); insert into seat_table_backup select * from seat_table_0 ; end")
		
		for i in xrange(0,6):
			cur.execute("drop event if exists move"+ str(i+1) +"_" + str(i) + "event")
			second = (i * 5)
			second = second + 10
 			cur.execute("create event move"+str(i+1) + "_" + str(i) + "event on schedule every 1 day starts '2016-02-01 00:00:" + str(second) + "' do begin drop table if exists seat_table_"+ str(i) +"; create table seat_table_"+ str(i) +"( seatnum int , period0 int , period1 int , period2 int , period3 int , period4 int , ownerPeriod0 varchar(20) , ownerPeriod1 varchar(20) ,ownerPeriod2 varchar(20) ,ownerPeriod3 varchar(20) ,ownerPeriod4 varchar(20) , seatsType int); insert into seat_table_"+ str(i)+" select * from seat_table_"+ str(i+1)+" ; end")

 		insertstr = ""
 		for j in xrange(0,10):
 			insertstr += " insert into seat_table_6 values( '"+ str(j) +"' , 0 , 0,  0 , 0, 0 , NULL , NULL , NULL , NULL , NULL , '0');"
		cur.execute("drop event if exists deal6event")
		cur.execute("create event deal6event on schedule every 1 day starts '2016-02-01 00:00:45' do begin drop table seat_table_6; create table seat_table_6 ( seatnum int , period0 int , period1 int , period2 int , period3 int , period4 int , ownerPeriod0 varchar(20) , ownerPeriod1 varchar(20) ,ownerPeriod2 varchar(20) ,ownerPeriod3 varchar(20) ,ownerPeriod4 varchar(20) , seatsType int) ; "+ insertstr +" end")
		
		conn.commit()
		cur.close()
		conn.close()
	except MySQLdb.Error, e:
		print "Mysql Error %d: %s" % (e.args[0], e.args[1])

if __name__ == '__main__':
	print "makeUserTables..."
	makeUserTables()
	print "makeCloseUserTables"
	makeCloseUserTables()
	print "makeSeatTables()"
	makeSeatTables()
	print "makeSeatTable0Events"
	makeSeatTable0Events()
	print "dayUpdateEvents"
	dayUpdateEvents()

