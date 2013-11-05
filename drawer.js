"use strict";

var drawer = function() {
    var VBO;
    var gl; // gl state
    var shaderProgram; // main program
    var viewMatrix; // main view matrix
    var vertCode =
        'attribute vec2 position;' +
        'uniform mat4 viewMat;' +
        'void main(void) {' +
        '  gl_Position = viewMat * vec4(position, 0.0, 1.0);' +
        '}';

    var fragCode =
        'void main(void) {' +
        '   gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);' +
        '}';

    function initShaders() {
        var vertShader = gl.createShader(gl.VERTEX_SHADER);
        gl.shaderSource(vertShader, vertCode);
        gl.compileShader(vertShader);
        if (!gl.getShaderParameter(vertShader, gl.COMPILE_STATUS))
            throw new Error(gl.getShaderInfoLog(vertShader));

        var fragShader = gl.createShader(gl.FRAGMENT_SHADER);
        gl.shaderSource(fragShader, fragCode);
        gl.compileShader(fragShader);
        if (!gl.getShaderParameter(fragShader, gl.COMPILE_STATUS))
            throw new Error(gl.getShaderInfoLog(fragShader));

        // Put the vertex shader and fragment shader together into
        // a complete program
        //
        shaderProgram = gl.createProgram();
        gl.attachShader(shaderProgram, vertShader);
        gl.attachShader(shaderProgram, fragShader);
        gl.linkProgram(shaderProgram);
        if (!gl.getProgramParameter(shaderProgram, gl.LINK_STATUS))
            throw new Error(gl.getProgramInfoLog(shaderProgram));
            
            
        gl.useProgram(shaderProgram);
        
        var viewMatrixLocation = gl.getUniformLocation(shaderProgram, "viewMat");
        gl.uniformMatrix4fv(viewMatrixLocation, false, viewMatrix);
    }
        
    var setup = function(glState) {
        gl = glState;
        VBO = gl.createBuffer();
        gl.bindBuffer(gl.ARRAY_BUFFER, VBO);
        
        viewMatrix = mat4.create();
        mat4.ortho(viewMatrix, 0, 500, 500, 0, -1, 1);
        
        initShaders();
    }
    
    var enableBindings = function() {
        // Tell WebGL which shader program to use
        //
        gl.useProgram(shaderProgram);

        // Tell WebGL that the data from the array of triangle
        // coordinates that we've already copied to the graphics
        // hardware should be fed to the vertex shader as the
        // parameter "position"
        //
        var coordinatesVar = gl.getAttribLocation(shaderProgram, "position");
        gl.enableVertexAttribArray(coordinatesVar);
        gl.vertexAttribPointer(coordinatesVar, 2, gl.FLOAT, false, 0, 0);
    }
    
    var drawLine = function(x1, y1, x2, y2) {
        var lineData = [x1, y1, x2, y2];
        gl.bindBuffer(gl.ARRAY_BUFFER, VBO);
        gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(lineData), gl.STREAM_DRAW);
        
        enableBindings();
        
        gl.drawArrays(gl.LINES, 0, 2);
    }
    
    var drawCircle = function(x, y, radius) {
        var circleData = [];

        var count = Math.max(8, radius/2);
        
        for (var i = 0; i < count; ++i) {
            var theta = (i / count) * Math.PI * 2.0;
        
            circleData.push(Math.cos(theta) * radius + x);
            circleData.push(Math.sin(theta) * radius + y);
        }
        circleData.push(Math.cos(0) * radius + x);
        circleData.push(Math.sin(0) * radius + y);
        
        gl.bindBuffer(gl.ARRAY_BUFFER, VBO);
        gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(circleData), gl.STREAM_DRAW);
        
        enableBindings();
        
        gl.drawArrays(gl.TRIANGLE_FAN, 0, count);
    }
    
    return {
        drawCircle : drawCircle,
        drawLine : drawLine,
        setup : setup
    };
}();