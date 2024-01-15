# Use an official Ruby runtime as a parent image
FROM ruby:2.6.5

# Install Bundler 2.0.2
RUN gem install bundler -v 2.0.2

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install dependencies
RUN bundle install

# Copy the rest of the application code to the container
COPY . .

# Expose port 3000 to the outside world
EXPOSE 5432

# Command to run the application
CMD ["rails", "server", "-b", "0.0.0.0"]
