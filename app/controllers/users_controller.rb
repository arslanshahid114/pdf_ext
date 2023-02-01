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
          # match = employee.match /\s*(?<name>[A-Za-z]+\s[A-Za-z]*)\s+(?<position>[A-Za-z]+\s*[A-Za-z]*)\s+(?<office>[A-Za-z]+\s*[A-Za-z]*)\s+(?<age>[0-9]{1,3})\s+(?<start_date>[0-9]{4}-[0-9]{1,2}-[0-9]{1,2})\s+(?<salary>\$[0-9,]+)/
          match = employee.match /\s*(?<name>[A-Za-z]+\s[A-Za-z]*)\s+(?<position>[A-Za-z]+(. *?)+\s*[A-Za-z]*)\s+(?<office>[A-Za-z]+\s*[A-Za-z]*)\s+(?<age>[0-9]{1,3})\s+(?<start_date>[0-9]{4}-[0-9]{1,2}-[0-9]{1,2})\s+(?<salary>\$[0-9,]+)/
          
          next unless match
          User.create(
            name: match[:name].to_s.lstrip.rstrip,
              position: match[:position].to_s.lstrip.rstrip,
            office: match[:office].to_s.lstrip.rstrip,
            age: match[:age].to_s.lstrip.rstrip,
            start_date: match[:start_date].to_s.lstrip.rstrip,
            salary: match[:salary].to_s.lstrip.rstrip) 
          end
  
    end
  end
end
