# Thnkout 

Thnkout is the app allows us to think and output.
The reason why we need this app is as following.

 * We read info but no chance to output what you think
 * Just reading doesn't help your knowledge. Info is already shared by people. What makes difference is your opinion.
 * ... 


## System architecture

 - MongoDB to add the contents
 - MySQL to keep user's info

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
    
