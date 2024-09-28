class ReportsController < ApplicationController
  def index
    @reports = Report.all
  end

  def show
    @report = set_report
  end

  def new
    @report = Report.new
  end

  def edit
    @report = set_report
  end

  def create
    @report = current_user.reports.new(report_params)

    if @report.save
      redirect_to @report, notice: "Report was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @report = set_report

    if @report.update(report_params)
      redirect_to @report, notice: "Report was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report = set_report
    @report.destroy!
    redirect_to reports_path, status: :see_other, notice: "Report was successfully destoroyed."
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :body, :user_id)
  end
end
