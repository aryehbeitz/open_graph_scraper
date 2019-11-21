# Open Graph Scraper

### Versions
- Ruby version: 2.6.3
- Rails version 6.0.1
- Database: sqlite

### Set Up
- `rvm install 3.6.3`
- `bundle`
- `rake db:create`
- `rake db:migrate`
- `rails s -p 3004`
- `rake jobs:work`

### Testing with curl

- Request web site

```
curl -X POST http://localhost:3000/stories/\?url\=https://il.funzing.com
```

Response:

```
{"given_url":"https://il.funzing.com","found_canonical_url":"https://il.funzing.com/","token":"23c188f3160b02b0ad7c348480ceb314"}

```

Now use the token:

```
curl http://localhost:3000/stories/23c188f3160b02b0ad7c348480ceb314
```

Response:

```
{"id":11,"scrape_status":"pending"}
```

Run again:

```
curl http://localhost:3000/stories/23c188f3160b02b0ad7c348480ceb314
```

Now we have the data:

```
{"url":"https://il.funzing.com/","type":"website","title":"הכירו את Funzing - אתר הפנאי הגדול בישראל","images":[[{"url":"https://d1cgjtrsdeqk19.cloudfront.net/site-assets/v1/default-facebook-share/experiences_small_IL.jpg","type":null,"width":"770","height":"430","alt":null}]],"id":27,"updated_time":"2019-11-21T01:15:19.590+0000","scrape_status":"done"}
```