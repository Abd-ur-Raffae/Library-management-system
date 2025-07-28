class MembersController < ApplicationController
  before_action :require_librarian
  before_action :set_member, only: [ :show, :edit, :update, :destroy ]

  def index
    @members = Member.all
  end

  def show
    @current_borrowings = @member.borrowings.where(status: "borrowed").includes(:book)
    @borrowing_history = @member.borrowings.where(status: [ "returned", "overdue" ]).includes(:book)
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)
    @member.membership_date = Date.current
    @member.active = true

    if @member.save
      redirect_to @member, notice: "Member was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @member.update(member_params)
      redirect_to @member, notice: "Member was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    if @member.borrowings.where(status: "borrowed").any?
      redirect_to members_url, alert: "Cannot delete member with active borrowings."
    else
      @member.destroy
      redirect_to members_url, notice: "Member was successfully deleted."
    end
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:name, :email, :phone, :address, :membership_type, :active)
  end
end
