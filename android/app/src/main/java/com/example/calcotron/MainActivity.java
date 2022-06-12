package com.example.calcotron;

import android.os.Bundle;

import androidx.annotation.NonNull;

import java.util.ArrayList;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.flutter.java/parse";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("Parser")) {
                                BinaryTree.root = new Node(null);
                                Parser p;
                                String text = call.argument("text");
                                if (text == "" || text == null) text = "0";
                                BinaryTree.root = new Node(null);
                                try {
                                    p = new Parser(text);
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
//                                clearTree();  todo
                                double startint=-20;
                                if(text.contains("root")){
                                    startint=0;
                                }else if(text.contains("log") || text.contains("ln")){
                                    startint=0.0000000001;
                                }
                                ArrayList<double[]> list = new ArrayList();
                                list.clear();
                                    for (double i = startint; i <= 20; i += 0.1) {
                                        BinaryTree.value = i;
                                        double y = BinaryTree.evaluate(BinaryTree.root.left);
                                        list.add(new double[]{i, y});
                                    }
                                result.success(list);
                            }
                        }
                );
    }
}

class ChartData {
    public double x;
    public double y;

    public ChartData(double x, double y) {
        this.x = x;
        this.y = y;
    }
}
