# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# email, password, password_confirmation, first_name, last_name, admin
user_list = [
    ["admin@test.fi", "admin12", "admin12", "Adminfirst", "Adminlast", true],
    ["user@test.fi", "user12", "user12", "Userfirst", "Userlast", false]
]

# project_name: project_name, start_time: start_time, end_time: end_time
project_list = [
    ["Tuntikirjausjärjestelmä", Time.now - 10000, ""],
    ["Keskeneräinen", Time.now - 5000, ""],
    ["Toinen projekti", Time.now - 1000, Time.now - 3000],
    ["Projekti melko pitkällä otsikolla", Time.now - 100, Time.now - 300]
]

category_list = ["Frontend", "Backend"]

# task_name, start_time, end_time, project_id, task_category_id
task_list = [
    ["Tietokanta", Time.now - 10000, Time.now - 5000, 1, 2],
    ["Käyttöliittymä", Time.now - 1000, "", 1, 1],
    ["Suunnitteilla", "", "", 2, 2],
    ["Työn alla", Time.now - 5000, "", 2, 2],
    ["Valmis", Time.now - 10000, Time.now - 5000, 2, 2],
    ["Suunnitteilla", "", "", 3, 2],
    ["Työn alla", Time.now - 5000, "", 3, 2],
    ["Valmis", Time.now - 10000, Time.now - 5000, 3, 2]
]

user_task_list = [
    [1, 1, 30],
    [2, 1, 240]
]

user_list.each do |email, password, password_confirmation, first_name, last_name, admin|
    User.create!(email: email, password: password, password_confirmation: password_confirmation, first_name: first_name, last_name: last_name, admin: admin)
end


project_list.each do |project_name, start_time, end_time|
    Project.create(project_name: project_name, start_time: start_time, end_time: end_time)
end

category_list.each do |category_name|
    TaskCategory.create(category_name: category_name)
end

task_list.each do |task_name, start_time, end_time, project_id, task_category_id|
    Task.create(task_name: task_name, start_time: start_time, end_time: end_time, project_id: project_id, task_category_id: task_category_id)
end

user_task_list.each do |user_id, task_id, working_time|
    UserTask.create(user_id: user_id, task_id: task_id, working_time: working_time)
end