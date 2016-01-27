import MySQLdb

try:
	conn = MySQLdb.connect(host = 'localhost' , user = 'root' , passwd = 'root' , port = 3306 ,charset='utf8')
	cur = conn.cursor()


	cur.execute('create database if not exists seat_db')
	conn.select_db('seat_db')
	for j in xrange(0 , 7):
		cur.execute('create table seat_table_' + str(j) + '( seatnum int , period0 boolean , period1 boolean , period2 boolean , period3 boolean , period4 boolean , ownerPeriod0 varchar(20) , ownerPeriod1 varchar(20) ,ownerPeriod2 varchar(20) ,ownerPeriod3 varchar(20) ,ownerPeriod4 varchar(20) , seatsType int)')
		for k in xrange( 0 , 10):
			cur.execute('insert into seat_table_'+ str(j) + " values('" + str(k) + "', false , false,  false , false, false , NULL , NULL , NULL , NULL , NULL , '0')")
	conn.commit()
	cur.close()
	conn.close()
except MySQLdb.Error, e:
	print "Mysql Error %d: %s" % (e.args[0], e.args[1])

