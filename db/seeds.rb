# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'Cadastrando as CATEGORIAS...'
categories = ['Animais e acessórios',
              'Esportes',
              'Para a sua casa',
              'Eletrônicos e celulares',
              'Músicas e hobbies',
              'Bebês e crianças',
              'Moda e beleza',
              'Veículos e barcos',
              'Imóveis',
              'Empregos e negócios']

categories.each do |category|
  Category.friendly.find_or_create_by!(description: category)
end
puts 'CATEGORIAS cadastradas com sucesso!'

######################

puts 'Cadastrando o ADMINSTRADOR Padrão...'
  Admin.create!(
    name: 'Willian Lucio',
    email: 'admin@admin.com',
    password: '123456',
    password_confirmation: '123456',
    role: 0
  )
puts 'ADMINISTRADOR cadastrado com sucesso!'

######################

puts 'Cadastrando o MEMBRO Padrão...'
  member = Member.new(
    email: 'membro@membro.com',
    password: '123456',
    password_confirmation: '123456'
  )

  member.build_profile_member
  member.profile_member.first_name = "Membro"
  member.profile_member.second_name = "Padrão"
  member.save!
puts 'MEMBRO cadastrado com sucesso!'
