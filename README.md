# Deploy huboard

Register a new application at https://github.com/settings/applications

Make sure "Authorization callback URL" points to http://server/login/private


run:

```
bundle install
knife solo prepare root@server
```

Edit nodes/server.json based on nodes/sever.json.example

Run

```
knife solo cook root@server
```
