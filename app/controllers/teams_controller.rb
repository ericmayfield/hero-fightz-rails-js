class TeamsController < ApplicationController
    before_action :load_team, only: [:show, :edit, :update, :destroy]
    before_action :must_be_logged_in

    def index
        @teams = Team.all
    end
    
    def new
        @team = Team.new
    end

    def create
        @team = Team.new(team_params)

        if @team.save
            redirect_to team_path(@team)
        else
            render :new
        end
    end

    def show
    end

    def edit
    end

    def update
        @team.update(team_params)
        render :show
    end

    def destroy
        @team.delete
        redirect_to account_path
    end
     
    private
     
    def team_params
        params.require(:team).permit(:title)
    end

    def load_team
        if @team = Team.find_by(id: params[:id])
            @team
        else
            flash[:alert] = "This team does not exist."
            redirect_to account_path 
        end
    end

    def must_be_logged_in
        redirect_to root_path unless logged_in?
    end
end
