require 'sinatra'
require 'dotenv/load'

require_relative './src/routes/tasks_routes'

use TasksRoutes