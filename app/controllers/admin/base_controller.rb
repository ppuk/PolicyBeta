class Admin::BaseController < ApplicationController
  include Admin::Concerns::AccessRestriction
end
