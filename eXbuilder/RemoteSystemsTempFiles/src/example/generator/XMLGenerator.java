package example.generator;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;

public class XMLGenerator {

    public XMLGenerator() {

    }

    /**
     * 강의 목록을 가져옵니다.
     * @return ArrayList
     */
    private String getLecture() {
        ArrayList<String> list = new ArrayList<String>();
        list.add("영어");
        list.add("수학");
        list.add("과학");
        list.add("국어");
        list.add("국사");

        int result = (int) (Math.random() * list.size());
        return list.get(result);
    }

    /**
     * 점수를 가져옵니다.
     * @return
     */
    private int getScore() {
        int result = (int) (Math.random() * 100);
        return result;
    }

    /**
     *  XML의 내용을 가져옵니다.
     * @return String
     */
    private String getContents() {
        String text = "";
        int length = 12;
        text += "<root>\n";
        text += "\t<rptdata>\n";
        for (int i = 0; i < length; i++) {
            text += "\t\t<row>\n";
            text += "\t\t\t<col1>" + getLecture() + "</col1>\n";
            text += "\t\t\t<col2>" + getScore() + "</col2>\n";
            text += "\t\t</row>\n";
        }
        text += "\t</rptdata>\n";

        text += "</root>";
        return text;
    }

    /**
     * 완성된 XML 텍스트를 가져옵니다.
     * @return
     */
    public String getXML() {
        String text = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
        text += getContents();

        return text;
    }

    /**
     * 파일은 ./WebContent/instanceData/ 에 생성됩니다.
     * @param fileName
     */
    public void create(String fileName) {

        File file = new File("./WebContent/instanceData/"+fileName);
        try {
            FileOutputStream outputStream = new FileOutputStream(file);
            outputStream.write(getXML().getBytes());
            outputStream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 실행을 하면 XML 파일이 생성됩니다.
     * @param args
     */
    public static void main(String[] args) {
        XMLGenerator gen = new XMLGenerator();
        gen.create("sample.xml");

    }
}
