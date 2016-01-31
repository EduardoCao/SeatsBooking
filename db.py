import MySQLdb
import time

workspace = '/Users/Eduardo' # \! pwd

def makeSeatTables():
	try:
		conn = MySQLdb.connect(host = 'localhost' , user = 'root' , passwd = 'root' , port = 3306 ,charset='utf8')
		cur = conn.cursor()
		cur.execute('drop database seat_db')
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

		cur.execute("drop event if exists timeout_period0")
		cur.execute("create event timeout_period0 on schedule every 1 minute do update seat_table_0 set period0 = 2 where curtime() > '07:00'")

		cur.execute("drop event if exists timeout_period1")
		cur.execute("create event timeout_period1 on schedule every 1 minute do update seat_table_0 set period1 = 2 where curtime() > '09:00'")

		cur.execute("drop event if exists timeout_period2")
		cur.execute("create event timeout_period2 on schedule every 1 minute do update seat_table_0 set period2 = 2 where curtime() > '12:00'")

		cur.execute("drop event if exists timeout_period3")
		cur.execute("create event timeout_period3 on schedule every 1 minute do update seat_table_0 set period3 = 2 where curtime() > '14:00'")

		cur.execute("drop event if exists timeout_period4")
		cur.execute("create event timeout_period4 on schedule every 1 minute do update seat_table_0 set period4 = 2 where curtime() > '18:00'")
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
		cur.execute("create event backuptodayevent on schedule every 1 day starts '2016-02-01 00:00:00' do select * into outfile '"+  workspace + "/sqldatabc/" + time.strftime("%d_%m_%y") + ".log' from seat_table_0")
		

		cur.execute("drop event if exists move0_bcevent")
		cur.execute("create event move0_bcevent on schedule every 1 day starts '2016-02-01 00:00:03' do begin drop table if exists seat_table_backup; create table seat_table_backup( seatnum int , period0 int , period1 int , period2 int , period3 int , period4 int , ownerPeriod0 varchar(20) , ownerPeriod1 varchar(20) ,ownerPeriod2 varchar(20) ,ownerPeriod3 varchar(20) ,ownerPeriod4 varchar(20) , seatsType int); insert into seat_table_backup select * from seat_table_0 ; end")
		
		for i in xrange(0,6):
			cur.execute("drop event if exists move"+ str(i+1) +"_" + str(i) + "event")
			second = (i * 5)
			second = second + 10
 			cur.execute("create event move"+str(i+1) + "_" + str(i) + "event on schedule every 1 day starts '2016-02-01 00:00:" + str(second) + "' do begin drop table if exists seat_table_"+ str(i) +"; create table seat_table_"+ str(i) +"( seatnum int , period0 int , period1 int , period2 int , period3 int , period4 int , ownerPeriod0 varchar(20) , ownerPeriod1 varchar(20) ,ownerPeriod2 varchar(20) ,ownerPeriod3 varchar(20) ,ownerPeriod4 varchar(20) , seatsType int); insert into seat_table_"+ str(i)+" select * from seat_table_"+ str(i+1)+" ; end")

 		insertstr = ""
 		for j in xrange(0,10):
 			insertstr += "insert into seat_table_6 values( '"+ str(j) +"' , 0 , 0,  0 , 0, 0 , NULL , NULL , NULL , NULL , NULL , '0');"
		cur.execute("drop event if exists deal6event")
		cur.execute("create event deal6event on schedule every 1 day starts '2016-02-01 00:00:45' do begin drop table seat_table_6; create table seat_table_6 ( seatnum int , period0 int , period1 int , period2 int , period3 int , period4 int , ownerPeriod0 varchar(20) , ownerPeriod1 varchar(20) ,ownerPeriod2 varchar(20) ,ownerPeriod3 varchar(20) ,ownerPeriod4 varchar(20) , seatsType int) ; "+ insertstr +"end")
		
		conn.commit()
		cur.close()
		conn.close()
	except MySQLdb.Error, e:
		print "Mysql Error %d: %s" % (e.args[0], e.args[1])

if __name__ == '__main__':
	#makeSeatTables()
	#makeSeatTable0Events()
	dayUpdateEvents()

