public class AssignedCourse {
    private String courseCode;
    private String courseName;
    private String tid;
    private String teacherName;
    private String department;
    private String classYear;
    private String semester;

    public AssignedCourse(String courseCode, String courseName, String tid, String teacherName, String department, String classYear, String semester) {
        this.courseCode = courseCode;
        this.courseName = courseName;
        this.tid = tid;
        this.teacherName = teacherName;
        this.department = department;
        this.classYear = classYear;
        this.semester = semester;
    }

    public String getCourseCode() {
        return courseCode;
    }

    public String getCourseName() {
        return courseName;
    }

    public String getTid() {
        return tid;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public String getDepartment() {
        return department;
    }

    public String getClassYear() {
        return classYear;
    }

    public String getSemester() {
        return semester;
    }
}
