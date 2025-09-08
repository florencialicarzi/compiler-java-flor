package lyc.compiler;

import java.io.FileReader;
import java.io.InputStreamReader;

public class Main {
    public static void main(String[] args) throws Exception {
        Parser parser;

        if (args.length > 0) {
            // Si se pasa un archivo como argumento, lo abre
            parser = new Parser(new Lexer(new FileReader(args[0])));
        } else {
            // Si no se pasa nada, lee de la entrada estándar (stdin)
            parser = new Parser(new Lexer(new InputStreamReader(System.in)));
        }

        parser.parse();
        System.out.println("✅ Parsing completado sin errores.");
    }
}