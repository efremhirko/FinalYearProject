package lastproject;

public class Course {
    private String courseCode;
    private String courseTitle;
    private int ects;
    private int lectureHours;
    private int tutorialHours;
    private int labHours;
    private int batch;
    private String semester;
    private String department;
    
    // Constructor, getters, and setters

    public Course(String courseCode, String courseTitle, int ects, int lectureHours, int tutorialHours, int labHours, int batch, String semester, String department) {
        this.courseCode = courseCode;
        this.courseTitle = courseTitle;
        this.ects = ects;
        this.lectureHours = lectureHours;
        this.tutorialHours = tutorialHours;
        this.labHours = labHours;
        this.batch = batch;
        this.semester = semester;
        this.department = department;
    }

    public String getCourseCode() {
        return courseCode;
    }

    public void setCourseCode(String courseCode) {
        this.courseCode = courseCode;
    }

    public String getCourseTitle() {
        return courseTitle;
    }

    public void setCourseTitle(String courseTitle) {
        this.courseTitle = courseTitle;
    }

    public int getEcts() {
        return ects;
    }

    public void setEcts(int ects) {
        this.ects = ects;
    }

    public int getLectureHours() {
        return lectureHours;
    }

    public void setLectureHours(int lectureHours) {
        this.lectureHours = lectureHours;
    }

    public int getTutorialHours() {
        return tutorialHours;
    }

    public void setTutorialHours(int tutorialHours) {
        this.tutorialHours = tutorialHours;
    }

    public int getLabHours() {
        return labHours;
    }

    public void setLabHours(int labHours) {
        this.labHours = labHours;
    }

    public int getBatch() {
       
        return batch;
    }

    public void setBatch(int batch) {
        this.batch = batch;
    }

    public String getSemester() {
        return semester;
    }

    public void setSemester(String semester) {
        this.semester = semester;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }
    
}
