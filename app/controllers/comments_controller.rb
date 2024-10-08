# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_current_user_comment, only: %i[edit update destroy]

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: @comment.model_name.human)
    else
      render_commentable_show(@comment, status: :unprocessable_entity)
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to @commentable, notice: t('controllers.common.notice_update', name: @comment.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to @commentable, status: :see_other, notice: t('controllers.common.notice_destroy', name: @comment.model_name.human)
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :body)
  end

  def set_commentable
    if params[:book_id]
      @commentable = Book.find(params[:book_id])
    elsif params[:report_id]
      @commentable = Report.find(params[:report_id])
    end
  end

  def set_current_user_comment
    @comment = current_user.comments.find_by(id: params[:id], commentable: @commentable)
  end

  def render_commentable_show(comment, status: :ok)
    case @commentable
    when Book
      @book = @commentable
      @comments = @book.comments.includes(:user)
      @comment = comment
      render 'books/show', status: status
    when Report
      @report = @commentable
      @comments = @report.comments.includes(:user)
      @comment = comment
      render 'reports/show', status: status
    end
  end
end
