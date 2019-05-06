class HerosController < ApplicationController
    before_action :load_hero, only: [:show, :edit, :update, :destroy]
    before_action :belongs_to_user, except: [:new, :create, :index]
    before_action :must_be_logged_in

    def index
        if params[:team_id]
            @heros = Hero.heros_by_team_id(params[:team_id])

            if params[:search]
                # @heros = @heros.select { |hero| hero.name.downcase.include?(params[:search].downcase) }
                @heros = @heros.where('name LIKE ?', "%#{params[:search]}%")
            else
                @heros
            end
        else
            @heros = current_user.heros

            if params[:search]
                #@heros = @heros.select { |hero| hero.name.downcase.include?(params[:search].downcase) }
                @heros = @heros.where('name LIKE ?', "%#{params[:search]}%")
            else
                @heros
            end
        end
    end

    def show
    end

    def new
        if params[:user_id]
            @hero = Hero.new(user_id: params[:user_id])
        else
            @hero = Hero.new
        end
    end

    def create
        @hero = Hero.new(hero_params)

        if @hero.save
            render :show
        else
            render :new
        end
    end

    def edit
    end

    def update
        @hero.update(hero_params)
        render :show
    end

    def destroy
        @hero.delete
        redirect_to account_path
    end

    private

    def hero_params
        params.require(:hero).permit(:name, :battle_cry, :bio, :img_path, :user_id, :team_id)
    end

    def load_hero
        @hero = Hero.find_by(id: params[:id])
    end

    # Ensures that a Hero belongs to a user for all actions
    def belongs_to_user
        if @hero.user_id != current_user.id
            flash[:alert] = "This hero does not belong to you."
            redirect_to account_path
        end
    end

    # Must be logged_in for all actions
    def must_be_logged_in
        redirect_to root_path unless logged_in?
    end
end
