#!/usr/bin/env python
import time
import string
import httplib, sys
from socket import *
import re
import getopt

print "\n*************************************"
print "*TheHarvester Ver. 1.4b             *"
print "*Coded by Christian Martorella      *"
print "*Edge-Security Research             *"
print "*cmartorella@edge-security.com      *"
print "*************************************\n\n"

global word
global w
global result
result = []

def usage():

 print "Usage: theharvester options \n"
 print "       -d: domain to search or company name\n"
 print "       -l: limit the number of results to work with(msn goes from 50 to 50 results,"
 print "            google 100 to 100, and pgp does'nt use this option)\n"
 print "       -b: data source (google,msn,pgp,linkedin)\n"
 print "\nExamples:./theharvester.py -d microsoft.com -l 500 -b google\n"
 print "         ./theharvester.py -d microsoft.com -b pgp\n"
 print "         ./theharvester.py -d microsoft -l 200 -b linkedin\n"

def howmanymsn(w):
	h = httplib.HTTP('search.msn.com')
	h.putrequest('GET', "/results.aspx?mkt=en-en&q=%40" + w + "&FORM=QBHP")
	h.putheader('Host', 'search.msn.com')
	h.putheader('User-agent', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-us) AppleWebKit/523.15.1 (KHTML, like Gecko) Version/3.0.4 Safari/523.15')
	h.endheaders()
	returncode, returnmsg, headers = h.getreply()
	data = h.getfile().read()
	r1 = re.compile('of [0123456789,]* results')
	result = r1.findall(data)
	for x in result:
		clean = re.sub('of', '', x)
		clean = re.sub('results', '', clean)
		clean = re.sub(',', '', clean)
	return clean

def howmanygoogle(w):
		h = httplib.HTTP('www.google.com')
		if engine == "google":
				h.putrequest('GET', "/search?num=100&hl=en&btnG=B%C3%BAsqueda+en+Google&meta=&q=%40" + w)
		else:
				h.putrequest('GET', "/search?num=10&hl=en&btnG=B%C3%BAsqueda+en+Google&meta=&q=site%3Alinkedin.com%20" + w)
		h.putheader('Host', 'www.google.com')
		h.putheader('User-agent', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-us) AppleWebKit/523.15.1 (KHTML, like Gecko) Version/3.0.4 Safari/523.15')
		h.endheaders()
		returncode, returnmsg, headers = h.getreply()
		data = h.getfile().read()
		if engine == "google":
			r1 = re.compile('about <b>[0123456789,]*</b> for')
		else:
			r1 = re.compile('about <b>[0123456789,]*</b> from')
		result = r1.findall(data)
		for x in result:
				clean = re.sub(' <b>', '', x)
				clean = re.sub('</b> ', '', clean)
				clean = re.sub('about', '', clean)
				clean = re.sub('for', '', clean)
				clean = re.sub(',', '', clean)
				clean = re.sub('from', '', clean)
		return clean

def run_msn(w, i):
	h = httplib.HTTP('search.msn.com')
	h.putrequest('GET', "/results.aspx?mkt=en-en&q=%40" + w + "&FORM=QBHP&first=" + str(i))
	h.putheader('Host', 'search.msn.com')
	h.putheader('Cookie', 'SRCHUID=V=1&NRSLT=50;')
	h.putheader('User-agent', 'Internet Explorer 6.0 ')
	h.endheaders()
	returncode, returnmsg, headers = h.getreply()
	data = h.getfile().read()
	data = string.replace(data, '<strong>', '')
 	data = string.replace(data, '</strong>', '')
	r1 = re.compile('[a-zA-Z0-9.-_]*' + '@' + '[a-zA-Z0-9.-]*' + w + ' ')
	res = r1.findall(data)
	print data
	return res

def run(w, i, eng):
	if eng == "msn":
		h = httplib.HTTP('search.msn.com')
		h.putrequest('GET', "/results.aspx?q=%40" + w + "&FORM=QBHP&first=" + str(i))
		h.putheader('Host', 'search.msn.com')
		h.putheader('Cookie', 'SRCHUID=V=1&NRSLT=50;')
	if eng == "linkedin":
		h = httplib.HTTP('www.google.com')
		h.putrequest('GET', "/search?num=100&start=" + str(i) + "&hl=es&btnG=B%C3%BAsqueda+en+Google&meta=&q=site%3Alinkedin.com%20" + w)
		h.putheader('Host', 'www.google.com')
	elif eng == "google":
		h = httplib.HTTP('www.google.com')
		h.putrequest('GET', "/search?num=100&start=" + str(i) + "&hl=es&btnG=B%C3%BAsqueda+en+Google&meta=&q=%40\"" + w + "\"")
		h.putheader('Host', 'www.google.com')
	elif eng == "pgp":
		h = httplib.HTTP('pgp.rediris.es:11371')
		h.putrequest('GET', "/pks/lookup?search=" + w + "&op=index")
		h.putheader('Host', 'pgp.rediris')
	h.putheader('User-agent', 'Internet Explorer 6.0 ')
	h.endheaders()
	returncode, returnmsg, headers = h.getreply()
	data = h.getfile().read()
	if eng == "msn":
 		data = string.replace(data, '<strong>', '')
 		data = string.replace(data, '</strong>', '')
	elif eng == "google":
		data = re.sub('<b>', '', data)
		data = re.sub('<em>', '', data)
		for e in ('>', ':', '=', '<', '/', '\\', ';'):
			data = string.replace(data, e, ' ')
	elif eng == "linkedin":
		re1 = re.compile('class=l>[a-zA-Z ,._-]* - LinkedIn</a>')
		res = re1.findall(data)
		resul = []
		for x in res:
				y = string.replace(x, ' - LinkedIn</a>', '')
				y = string.replace(y, 'class=l>', '')
				y = string.replace(y, '</a>', '')
				resul.append(y)
		return resul
	else:
		data = string.replace(data, '&lt;', ' ')
		data = string.replace(data, '&gt;', ' ')
	r1 = re.compile('[a-zA-Z0-9.-_]*' + '@' + '[a-zA-Z0-9.-]*' + w + ' ')
	res = r1.findall(data)
	return res

def test(argv):
	global limit
	limit = 100
	if len(sys.argv) < 4:
		usage()
		sys.exit()
	try :
	       opts, args = getopt.getopt(argv, "l:d:b:")
	except getopt.GetoptError:
  	     	usage()
		sys.exit()
	for opt, arg in opts :
       		if opt == '-l' :
       			limit = int(arg)
    	   	elif opt == '-d' :
			word = arg
		elif opt == '-b':
			global engine
			engine = arg
			if engine not in ("msn", "google", "linkedin", "pgp", "all"):
				usage()
				print "Invalid search engine, try with: msn, google, linkedin, pgp"
				sys.exit()

	print "Searching for " + word + " in " + engine + " :"
	print "======================================\n"
	if engine == "msn":
		total = int(howmanymsn(word))
	elif engine == "google":
		total = int(howmanygoogle(word))
	elif engine == "linkedin":
		word = word.replace(' ', '%20')
		total = int(howmanygoogle(word))
	else:
		res = run(word, 0, engine)
		if res == "":
			print "0 account found"
		else:
			for x in res:
				print x
			sys.exit()
	print "Total results: ", total
	cant = 0
	if total < limit:
 			limit = total
	print "Limit: ", limit
	while cant < limit:
		print "Searching results: " + str(cant) + "\r"
		res = run(word, cant, engine)
		for x in res:
	                if result.count(x) == 0:
               		        result.append(x)
		if engine == 'google':
			cant += 100
		elif engine == 'msn':
			cant += 50
		elif engine == 'linkedin':
			cant += 100

	print "\nAccounts found:"
	print "====================\n"
	t = 0
	for x in result:
		x = re.sub('<li class="first">', '', x)
		x = re.sub('</li>', '', x)
		print x
		t += 1
	print "====================\n"
	print "Total results: ", t

if __name__ == "__main__":
        try: test(sys.argv[1:])
	except KeyboardInterrupt:
		print "Search interrupted by user.."
	except:
		sys.exit()

