//usr/bin/env jbang "$0" "$@" ; exit $?
//DEPS info.picocli:picocli:4.1.4 net.dongliu:requests:5.0.8
//DEPS com.fasterxml.jackson.core:jackson-databind:2.9.8
//JAVA_OPTIONS -Djava.util.logging.config.file=log.properties

import picocli.CommandLine;
import picocli.CommandLine.Command;
import picocli.CommandLine.Option;
import picocli.CommandLine.Parameters;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.Callable;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import net.dongliu.requests.Requests;

@Command(name = "updatequay", mixinStandardHelpOptions = true, version = "updatequay 0.1",
        description = "updatequay made with jbang")
class updatequay implements Callable<Integer> {

    @Option(names="--token", required = true)
    private String token;

    public static void main(String... args) {
        int exitCode = new CommandLine(new updatequay()).execute(args);
        System.exit(exitCode);
    }

    @Override
    public Integer call() throws Exception { // your business logic goes here...
        
    // set headers by map
    Map<String, Object> headers = new HashMap<>();
    headers.put("Content-Type", "application/json");
    headers.put("Authorization", "Bearer " + token);

    ObjectMapper objectMapper = new ObjectMapper();

    Path p = new File("README.md").toPath();
    String desc = Files.readString(p);
    
    Map<String, String> map = new HashMap<>();
    map.put("description", desc);
    String payload = new ObjectMapper().writeValueAsString(map);

    JsonNode jsonNode = objectMapper.readTree(payload);
    
    String resp = Requests.put("https://quay.io/api/v1/repository/jbangdev/jbang-action")
                .headers(headers)
                .jsonBody(jsonNode)
                .send().readToText();
    
    System.out.println(resp);
    return 0;
    }
}
