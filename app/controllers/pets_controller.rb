class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params[:pet][:owner_id].nil?
      owners = Owner.find(params[:pet][:owner_id])
      owners.collect do |owner|
        owner.pets << @pet
        owner.save
      end
    end
    if !params[:owner][:name].empty?
      owner = Owner.create(name: params[:owner][:name])
      owner.pets << @pet
      owner.save
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    @owner = Owner.find(@pet.owner_id)
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params[:pet][:owner_id].nil?
      owners = Owner.find(params[:pet][:owner_id])
      owners.collect do |owner|
        owner.pets << @pet
        owner.save
      end
    end
    if !params[:owner][:name].empty?
      owner = Owner.create(name: params[:owner][:name])
      owner.pets << @pet
      owner.save
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
