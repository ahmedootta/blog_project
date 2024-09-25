# Blog Application

## Project Overview

This Blog Application provides a RESTful API that enables user authentication and CRUD operations for blog posts. Users can create, edit, delete posts, and manage comments. The application employs JWT for secure authentication and utilizes Sidekiq and Redis to manage scheduled tasks, such as automatic post deletion after a specified time.

## Features

### User Authentication
- **Signup**: Users can create an account with the following fields:
  - `name`
  - `email`
  - `password`
  - `image`
  
- **Login**: Users log in using their email and password.
- **Token-based Authentication**: All API endpoints are protected and require a valid JWT token for access.

### Post Management (CRUD)
- **Create Posts**: Users can create posts with the following fields:
  - `title`
  - `body`
  - `author` (linked to the user model)
  - `tags` (each post must have at least one tag)
  - `comments` (users can add comments to posts)

- **Read Posts**: Users can retrieve all posts or a specific post by its ID.
  
- **Update Posts**: Users can update their own posts, including modifying the tags.
  
- **Delete Posts**: Posts are automatically deleted 24 hours after their creation.

### Comment Management
- Users can add comments to any post.
- Users can edit or delete their own comments.

## Technologies Used
- **Ruby on Rails**: Framework for building the API.
- **PostgreSQL**: Database for storing user and post data.
- **Sidekiq**: Background processing for scheduling tasks (e.g., post deletion).
- **Redis**: Used alongside Sidekiq for job management.
- **Docker**: Containerization for easy deployment and management of the application.
