class WelcomeController < ApplicationController
    def home
        @heros = Hero.last_four_heros
    end
end
