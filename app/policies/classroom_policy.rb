class ClassroomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == 'admin'
        scope.all
      else
        scope.where(user: user)
      end
    end
  end

  def new?
    true
  end

  def create?
    true
  end

  def show?
    # parent of student in this classroom can see
    # teacher of this classroom can see
    # raise
    record.user == user || record.parents.any? { |parent| parent == user }
    # raise
    
  end

  def edit?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end

  def roster?
    true
  end
end
