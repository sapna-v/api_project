# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login signup]

  def signup
    @user = User.create(user_params)
    if @user.save
      response = { message: 'User created successfully' }
      render json: response, status: :created
    else
      render json: @user.errors, status: 400
    end
  end

  def login
    authenticate params[:email], params[:password]
  end

  def test
    render json: {
      message: 'You have passed authentication and authorization test'
    }
  end

  def index
    render json: User.public_fields.all
  end

  def create
    signup
  end

  def delete
    @user = fetch_user_by_email
    if @user.nil?
      message = 'User not found.'
      status_code = 400
    elsif @user.delete
      message = 'User successfully deleted.'
      status_code = 200
    else
      message = @user.errors
      status_code = 400
    end
    render json: message, status: status_code
  end

  def edit
    user = fetch_user_by_email
    if user.present?
      update user
      return
    end
    render json: { message: 'User not found.' }, status: 400
  end

  def sort
    if params[:sort_by].nil?
      render json: { message: 'Sort field is not present.' }, status: 422
    else
      if User.valid_field?(params[:sort_by])
        render json: User.public_fields.order(params[:sort_by]), status: 200
      else
        render json: 'Invalid sort parameter', status: 400
      end
    end
  end

  def filter
    if params[:filter_by].nil? || params[:value].nil?
      render json: { message: 'Filter by field and value both are required.' }, status: 422
    else
      if User.valid_field?(params[:filter_by])
        render json: User.public_fields.where("#{params[:filter_by]} like '%#{params[:value]}%'"), status: 200
      else
        render json: 'Invalid filter by parameter', status: 400
      end
    end
  end

  def disable
    @user = fetch_user_by_email
    if @user.present?
      if @user.disable.save
        render json: { message: 'User successfully disabled.' }, status: 200
      else
        render json: @user.errors, status: 400
      end
    else
      render json: { message: 'User not found.' }, status: 400
    end
  end

  def add_tag
    @user = fetch_user_by_email
    @tag = Tag.find_by(name: params[:tag_name])
    if @user.present? && @tag.present?
      @user.tags << @tag
      if @user.save
        render json: { message: 'Tag successfully added to user' }, status: 200
      else
        render json: @user.errors, status: 400
      end
    else
      render json: { message: 'User or tag not found.' }, status: 400
    end
  end

  def remove_tag
    @user = fetch_user_by_email
    @tag = Tag.find_by(name: params[:tag_name])
    if @user.present? && @tag.present?
      unless @user.tags.include?(@tag)
        render json: {message: 'User not associated with tag'}, status: 400
        return
      end
      if @user.tags.delete(@tag)
        render json: { message: 'Tag successfully removed from user' }, status: 200
      else
        render json: @user.errors, status: 400
      end
    else
      render json: { message: 'User or tag not found.' }, status: 400
    end
  end

  private

  def fetch_user_by_email
    user_email = params[:email]
    unless user_email.present?
      render json: { message: 'Email not present.' }, status: 422
    end
    User.find_by(email: user_email)
  end

  def update(user)
    if user.update!(update_user_params)
      response = { message: 'User updated successfully' }
      render json: response, status: 200
    else
      render json: @user.errors, status: 400
    end
  end

  def user_params
    params.permit(:name, :email,
                  :password, :gender, :address, :age)
  end

  def update_user_params
    # Email should not be changed.
    # Other user should not change password(Security resaons)
    if @current_user.email == params[:email]
      params.permit(:name, :gender, :address,
                    :password, :age)
    else
      params.permit(:name, :gender, :address, :age)
    end
  end

  def authenticate(email, password)
    command = AuthenticateUser.call(email, password)
    if command.success?
      render json: {
        access_token: command.result,
        message: 'Login Successful'
      }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end
