import subprocess

#stolen from emacswiki

def get_output(cmd):
    # Bunch of boilerplate to catch the output of a command:
    pipe = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
    (output, errout) = pipe.communicate()
    assert pipe.returncode == 0
    thing = output.strip().split("\n")[-1].strip('"')
    return thing


def get_password_emacs(host, port):
    cmd = "emacsclient -a \"\" --eval '(offlineimap-get-password \"%s\" \"%s\")'" % (host,port)
    return get_output(cmd).strip().lstrip('"').rstrip('"')

def get_user_emacs(host, port):
    cmd = "emacsclient -a \"\" --eval '(offlineimap-get-login \"%s\" \"%s\")'" % (host,port)
    return get_output(cmd).strip().lstrip('"').rstrip('"')

# stolen from http://roland.entierement.nu/blog/2010/09/08/gnus-dovecot-offlineimap-search-a-howto.html

# Propagate gnus-expire flag
from offlineimap import imaputil

def lld_flagsimap2maildir(flagstring):
    flagmap = {'\\seen': 'S',
               '\\answered': 'R',
               '\\flagged': 'F',
               '\\deleted': 'T',
               '\\draft': 'D',
               'gnus-expire': 'E'}
    retval = []
    imapflaglist = [x.lower() for x in flagstring[1:-1].split()]
    for imapflag in imapflaglist:
        if flagmap.has_key(imapflag):
            retval.append(flagmap[imapflag])
        retval.sort()
    return retval

def lld_flagsmaildir2imap(list):
    flagmap = {'S': '\\Seen',
               'R': '\\Answered',
               'F': '\\Flagged',
               'T': '\\Deleted',
               'D': '\\Draft',
               'E': 'gnus-expire'}
    retval = []
    for mdflag in list:
        if flagmap.has_key(mdflag):
            retval.append(flagmap[mdflag])
    retval.sort()
    return '(' + ' '.join(retval) + ')'

imaputil.flagsmaildir2imap = lld_flagsmaildir2imap
imaputil.flagsimap2maildir = lld_flagsimap2maildir

# Grab some folders first, and archives later
high = ['^important$', '^work$']
low = ['^archives', '^spam$']
import re

def lld_cmp(x, y):
    for r in high:
        xm = re.search (r, x)
        ym = re.search (r, y)
        if xm and ym:
            return cmp(x, y)
        elif xm:
            return -1
        elif ym:
            return +1
    for r in low:
        xm = re.search (r, x)
        ym = re.search (r, y)
        if xm and ym:
            return cmp(x, y)
        elif xm:
            return +1
        elif ym:
            return -1
    return cmp(x, y)
