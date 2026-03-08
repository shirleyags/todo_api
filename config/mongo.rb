require 'mongo'
require 'dotenv/load'
require 'logger'

Mongo::Logger.logger.level = Logger::FATAL

client = Mongo::Client.new(ENV['MONGO_URL'])
TASKS_COLLECTION = client[:tasks]