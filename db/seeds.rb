# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'consul@policon.com', password: '123456', role: 0) #Rol Consulta
User.create(email: 'asist@policon.com', password: '123456', role: 1) #Rol Asistencia
User.create(email: 'admin@policon.com', password: '123456', role: 2) #Rol Administración

prof1 = Professional.create(name: "Juan Fernandez")
prof2 = Professional.create(name: "Maria Perez")

Appointment.create(date:DateTime.new(2022, 01, 01, 15, 0, 0),name: "Emiliano", surname: "Lopez", phone: 12345678, professional_id: prof1.id)
Appointment.create(date:DateTime.new(2022, 01, 01, 10, 0, 0),name: "Antonela", surname: "Sosa", phone: 3456789012, professional_id: prof2.id)