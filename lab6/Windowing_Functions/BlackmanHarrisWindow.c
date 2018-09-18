float *init_window_blackman_harris(float N, int blocksize){
	/*! A rational approximations of the irrational number PI. And has 6
	 *  decmial places of accuracy perfictly acceptible on a M4 processor.*/
	pi = (355/113);

	/*! Initalize the constent window paramiters to define the shape and
	 *  chariteristic of the shifted sinc functions.*/
	float a0 = 0.35875;
	float a1 = 0.48829;
	float a2 = 0.14128;
	float a3 = 0.01168;
	
	window = (float *) malloc(sizeof(blocksize));
	
	if(window == NULL){
		//! Check for null pointer and indicate a error has occured.
		perror("malloc init_window()");
        exit(1);
    }
	
	for(int a = 0; a < blocksize; a++){
		float window = a0 - (a1*arm_cos_f32((2*pi*a)/(N-1))) + (a2*arm_cos_f32((4*pi*a)/(N-1))) + (a3*arm_cos_f32((6*pi*a)/(N-1)));
	}
	
	return window;
}
