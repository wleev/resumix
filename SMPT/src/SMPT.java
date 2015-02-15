/**
 * Created by wlee on 1/25/2015.
 */

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfTemplate;
import com.itextpdf.text.pdf.PdfWriter;
import org.apache.batik.transcoder.TranscoderInput;
import org.apache.batik.transcoder.print.PrintTranscoder;
import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.BasicParser;
import org.apache.commons.cli.Options;

import java.awt.*;
import java.awt.Rectangle;
import java.awt.print.PageFormat;
import java.awt.print.Paper;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class SMPT {

    public static void main(String[] args) throws Exception {
        String currentDir = System.getProperty("user.dir");
        CommandLineParser cliParser = new BasicParser();
        Options cliOptions = new Options();
        cliOptions.addOption("f", true, "Input SVG file" );
        cliOptions.addOption("p", true, "Number of A4 pages in the resume");
        cliOptions.addOption("o", true, "Output PDF file");

        CommandLine cmd = cliParser.parse(cliOptions, args);

        if(!cmd.hasOption("f")) {
            System.err.println("Aborted. Please specify an input file with the -f flag.");
        }
        if(!cmd.hasOption("p")) {
            System.err.println("Aborted. Please specify the number of pages in the given input file.");
        }

        String outputFile = "output.pdf";
        if(!cmd.hasOption("o")) {
            System.out.println("No output file specified, defaulting to output.pdf");
        } else {
            outputFile = new File(currentDir, cmd.getOptionValue("o")).getAbsolutePath();
        }

        String inputFile = new File(currentDir, cmd.getOptionValue("f")).toURI().toURL().toString();
        int numberPages = Integer.parseInt(cmd.getOptionValue("p"));

        System.out.println("Starting conversion of SVG file : "+inputFile);
        System.out.print("to a PDF file with "+numberPages+" pages ");
        System.out.println(" at location : " + outputFile);

        Document document = new Document(PageSize.A4);
        try {
            PdfWriter writer = PdfWriter.getInstance(document,
                    new FileOutputStream(outputFile));
            document.open();

            PdfContentByte cb = writer.getDirectContent();

            float width = PageSize.A4.getWidth();
            float height = PageSize.A4.getHeight();

            for(int i = 0; i < numberPages; i++) {
                PdfTemplate template = cb.createTemplate(width, height);
                Graphics2D g2d = template.createGraphics(width, height);

                PrintTranscoder prm = new PrintTranscoder();
                prm.addTranscodingHint(PrintTranscoder.KEY_AOI, new Rectangle(0, i * 3510, 2490, 3510));
                prm.addTranscodingHint(PrintTranscoder.KEY_WIDTH, new Float(2490));
                prm.addTranscodingHint(PrintTranscoder.KEY_HEIGHT, new Float(3510));
                TranscoderInput ti = new TranscoderInput(inputFile);
                prm.transcode(ti, null);

                PageFormat pg = new PageFormat();
                Paper pp = new Paper();
                pp.setSize(width, height);
                pp.setImageableArea(0, 0, width, height);
                pg.setPaper(pp);
                prm.print(g2d, pg, 0);

                g2d.dispose();
                cb.addTemplate(template, 0, 0);

                if (i < numberPages - 1) {
                    document.newPage();
                }
            }

        } catch (DocumentException e) {
            System.err.println(e);
        } catch (IOException e) {
            System.err.println(e);
        }
        document.close();

    }
}
