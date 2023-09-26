
CREATE DATABASE advisemedb;
USE advisemedb;

CREATE TABLE AppRole(
    roleId INT NOT NULL AUTO_INCREMENT,
    roleName VARCHAR(70) NOT NULL,
    CONSTRAINT pk_role_id PRIMARY KEY (roleId)
);

CREATE TABLE User(
    userId INT NOT NULL AUTO_INCREMENT,
    appRoleId INT NOT NULL,
    email VARCHAR(70) NOT NULL,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(150) NOT NULL,
    createdAt DATETIME NOT NULL,
    updatedAt DATETIME ,

    CONSTRAINT pk_user PRIMARY KEY (userId),
    CONSTRAINT fk_app_role FOREIGN KEY (appRoleId) REFERENCES AppRole(roleId)
); 

CREATE TABLE PasswordRecoveryLog(
    logId INT NOT NULL AUTO_INCREMENT,
    userId INT NOT NULL,
    oldPassword VARCHAR(150) NOT NULL,
    createdAt DATETIME NOT NULL,
    updatedAt DATETIME ,
    
    CONSTRAINT pk_log_id PRIMARY KEY (logId),
    CONSTRAINT fk_user_id FOREIGN KEY (userId) REFERENCES User(userId)
);

CREATE TABLE FavoriteAdviceCategory(
    categoryId INT NOT NULL AUTO_INCREMENT,
    userId INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(300),
    createdAt DATETIME NOT NULL,
    updatedAt DATETIME,

    CONSTRAINT pk_category_id PRIMARY KEY (categoryId),
    CONSTRAINT fk_user_id_favorite_category FOREIGN KEY (userId) REFERENCES User(userId)
);


CREATE TABLE FavoriteAdvice(
    favoriteAdviceId INT NOT NULL AUTO_INCREMENT,
    categoryId INT NOT NULL,
    content VARCHAR(500),
    createdAt DATETIME NOT NULL,
    updatedAt DATETIME,

    CONSTRAINT pk_favorite_advice_id PRIMARY KEY (favoriteAdviceId),
    CONSTRAINT fk_category_id FOREIGN KEY (categoryId) REFERENCES FavoriteAdviceCategory(categoryId)

);



CREATE TABLE UserProfile(
    profileId INT NOT NULL AUTO_INCREMENT,
    userId INT NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    profileDescription VARCHAR(300) NOT NULL,
    profileImageLink VARCHAR(500),
    phoneNumber VARCHAR(20),
    createdAt DATETIME NOT NULL,
    updatedAt DATETIME ,

    CONSTRAINT pk_profile_id PRIMARY KEY (profileId),
    CONSTRAINT fk_user_id_profile FOREIGN KEY (userId) REFERENCES User(userId)

);

CREATE TABLE GuidanceHubPost(
    postId INT NOT NULL AUTO_INCREMENT,
    userId INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    content VARCHAR(500) NOT NULL,
    viewLevel ENUM("PUBLIC","PRIVATE") NOT NULL,
    receivedAdvicesVisibility ENUM("VISIBLE","INVISIBLE") NOT NULL,
    postAnonymity BOOLEAN NOT NULL,
    # The status indicates the current status of the post
    status ENUM("HIDDEN","EDITED","PUBLISHED","PENDING") NOT NULL,
    createdAt DATETIME NOT NULL,
    updatedAt DATETIME ,


    CONSTRAINT pk_post_id PRIMARY KEY (postId),
    CONSTRAINT fk_user_id_guidance_hub FOREIGN KEY (userId) REFERENCES User(userId)
);

CREATE TABLE GuidancePostAdvice(
    adviceId INT NOT NULL AUTO_INCREMENT,
    postId INT NOT NULL,
    userId INT NOT NULL,
    adviceAnonymity BOOLEAN NOT NULL,
    content VARCHAR(500) NOT NULL,
    # The status indicates the current status of the advice
    status ENUM("HIDDEN","EDITED","PUBLISHED","PENDING") NOT NULL,
    lastAllowableEditingDate DATETIME NOT NULL,
    createdAt DATETIME NOT NULL,
    updatedAt DATETIME ,

    CONSTRAINT pk_advice_id PRIMARY KEY (adviceId),
    CONSTRAINT fk_user_id_guidance_post_advice FOREIGN KEY (userId) REFERENCES User(userId),
    CONSTRAINT fk_post_id_guidance_post_advice FOREIGN KEY (postId) REFERENCES GuidanceHubPost(postId)
);


CREATE TABLE AdviceVote(
    voteId INT NOT NULL AUTO_INCREMENT,
    adviceId INT NOT NULL,
    userId INT NOT NULL,
    voteType ENUM("UP","DOWN") NOT NULL,


    CONSTRAINT pk_vote_id PRIMARY KEY (voteId),
    CONSTRAINT fk_user_id_advice_vote FOREIGN KEY (userId) REFERENCES User(userId),
    CONSTRAINT fk_advice_id FOREIGN KEY (adviceId) REFERENCES GuidancePostAdvice(adviceId)
);

CREATE TABLE Tag(
    tagId INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    createdAt DATETIME NOT NULL,
    updatedAt DATETIME ,

    CONSTRAINT pk_tag_id PRIMARY KEY(tagId)
);

CREATE TABLE TagGuidanceJointTable(
    tagId INT NOT NULL,
    postId INT NOT NULL,

    CONSTRAINT pk_tagid_postid PRIMARY KEY(tagId, postId),
    CONSTRAINT fk_tag_id FOREIGN KEY (tagId) REFERENCES Tag(tagId),
    CONSTRAINT fk_post_id_tag_guidance_joint_table FOREIGN KEY (postId) REFERENCES GuidanceHubPost(postId)
);
