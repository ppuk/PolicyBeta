class Account::BaseController < ApplicationController
  include Account::Concerns::AccessRestriction
end
