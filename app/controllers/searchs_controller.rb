class SearchsController < ApplicationController
  
  def search
    @user = User.new
    @book = Book.new
    @value = params["search"]["value"] 
    @model = params["search"]["model"]
    @how = params["search"]["how"] 
    @datas = search_for(@model, @value, @how) 
  end

  private

  def match(model, value) 
    if model == 'user' 
      User.where(name: value) 
    elsif model == 'book'
      Book.where(title: value)
    end
  end

  def forward(model, value)
    if model == 'user'
      User.where("name LIKE ?", "#{value}%") 
    elsif model == 'book'
      Book.where("title LIKE ?", "#{value}%")
    end
  end

  def backward(model, value)
    if model == 'user'
      User.where("name LIKE ?", "%#{value}")
    elsif model == 'book'
      Book.where("title LIKE ?", "%#{value}")
    end
  end

  def partical(model, value)
    if model == 'user'
      User.where("name LIKE ?", "%#{value}%")
    elsif model == 'book'
      Book.where("title LIKE ?", "%#{value}%")
    end
  end  

  def search_for(model, value, how)
    case how
    when 'match'
      match(model, value)
    when 'forward'
      forward(model, value)
    when 'backward'
      backward(model, value)
    when 'partical'
      partical(model, value)
    end
  end

end
