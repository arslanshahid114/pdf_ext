# require 'p'
class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    reader  = PDF::Reader.new("app/assets/#{params[:user][:file_path].original_filename}")
    reader.pages.each do |page|
      text = page.text
  
      employee_data = text.split("\n")
          actual_data = false
          employee_data.each do |employee|

          

          # if(employee.match /.+Name.+Position.+Office.+Age.+Start\sdate.+Salary*/)
          if(employee.match /^(\w+\s\w+)\s+([\w\s]+)\s+(\w+)\s+(\d+)\s+(\d{4}-\d{2}-\d{2})\s+\$(\d+,\d+)/)

            actual_data = true
          end

          next unless actual_data
          
          next if employee.strip.empty?
          name, position, office, age, start_date, salary = employee.split(" " * 6)
        
          puts "Name: #{name}"
          puts "Position: #{position}"
          puts "Office: #{office}"
          puts "Age: #{age}"
          puts "Start date: #{start_date}"
          puts "Salary: #{salary}"
          puts "---"
          end
  
    end
  end
end
