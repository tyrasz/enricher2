class ClassroomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin == true
        scope.all
      elsif user.role == "teacher"
        scope.where(user:user)
      elsif user.role == 'parent'
        user.student_classrooms
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

  def chatrooms?
    # record == array of classrooms
    # user == current_user
    # only allow if all classrooms belongs to the current_user
    # and the current_user is a teacher or the parent of the classroom
    
    # record.all? do |classroom|
      true
      # classroom.user == user || classroom.students.any? { |student| student == user }
    
  end

  def show_chat?
    raise
    record.all? do |classroom|
      true
    
    end
  end
end
