class CompanyPolicy < ApplicationPolicy
  def show?
    if user.admin? || user.companies.find_by(:id => record.id).present?
      return true
    else
      return false
  end
end
end
