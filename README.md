# Thnkout 

Thnkout is the app allows us to think and output.
The reason why we need this app is as following.

 * We read info but no chance to output what you think
 * Just reading doesn't help your knowledge. Info is already shared by people. What makes difference is your opinion.
 * ... 


## System architecture

 - MongoDB to add the contents
 - MySQL to keep user's info

### 

 - /topic/<topicID>

### Data strcuture

    "topicID": {
        childTopic: [topicID,,,],
        parentTopic: [topicID,,,],
        name: "NAME OF TOPIC",
        tags: [ "TAGA", "TAGB",, ],
        createdAt : "DATE"
        strategies:{
          "STRATEGY1" :{
              approaches:{
                  "APPROACH1": [
                    {user: "USER1", thoughts: "THOUGHTS SENTENCE", last_update: "DATE"},
                    {user: "USER2",,,}

    strategySet: { 
        STRATEGY1 : ["APPROACH1", "APPROACH2",,,,]
        ..
    }

    userTopic: [ topicID1,, ]


TABLE user (
    id BIGINT PRIAMRY KEY
    user_name VARCHAR
    email VARCHAR
    password # hash
    # and social info
);




example: 

    {
      topic :{
        name: "Become financial engineer",
        tag: [
          "finance",
          "engineering"
        ],
        strategies: {
          "SWOT": {
            approaches: {
              Strength: [
                {
                  user: "kamesho",
                  thoughts: "relatively good salary",
                  last_update: "201312071100"
                },
    


## Information Collection 

### data structure

- data source1 
 * point1 (with your own words, not copy as it is) 
 * point2
 * point3 
- data source 2 [hide] 
 * point 1

```javascript
   $scope.collection = {
      name: "abc",
      sources: [
        {
          sourceName: "source_title",
          points: [
            "point1",
            "point2"
          ]
        },
        {
          sourceName: "source_title2",
            points : [
              "point1",
              "point2"
            ]
        }
      ]
    };
```

My thoughts:  Put what you think from the above information. 

- GET /api/v1/information-collection/[themeID]
- PUT info-collection/[topic#]  - update
- DELETE
- POST - /api/v1/information-collection

## Database 

### MYSQL

user table -- pass, hash etc

user theme mapping 
user_id
theme_id 

### Mongo DB

theme_id : oid(mongodb)
theme: "考えるとは"
informationCollection: {}




