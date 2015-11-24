import os, subprocess, pprint
from sys import platform as _platform

from flask import Flask  
from flask import request  
app = Flask(__name__)

# check for ngrok subdomain

def displayNothing():
    return ''

def displayHTML(request):
    return 'Webhook server online! Go to <a href="https://bitbucket.com">Bitbucket</a> to configure your repository webhook for <a href="%s/webhook">%s/webhook</a>' % (request.url_root,request.url_root)

@app.route('/', methods=['GET'])
def index():  
    return displayHTML(request)

@app.route('/ping', methods=['GET'])
def ping():
    return displayNothing()

@app.route('/webhook', methods=['GET', 'POST'])
def tracking():  
    if request.method == 'POST':
        data = request.get_json()
        commit_url = data['push']['changes'][0]['new']['target']['links']['html']['href']
        repo_name = data['repository']['full_name']
        repo_name_only = data['repository']['name']
        commit_id = data['push']['changes'][0]['commits'][0]['hash']
        # Show notification if operating system is OS X
#        pprint.pprint(data['push'])
        subprocess.call(['/listener_root/scripts/bundle.sh', repo_name, commit_id, repo_name_only.lower()])
        return 'OK'
    else:
        return displayHTML(request)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
