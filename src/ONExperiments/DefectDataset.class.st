"
An experiment to explore the datasets in this repo:
https://github.com/awsm-research/Large-Defect-Prediction-Benchmark

"
Class {
	#name : #DefectDataset,
	#superclass : #Object,
	#classInstVars : [
		'rawData'
	],
	#category : #ONExperiments
}

{ #category : #accessing }
DefectDataset class >> for: json [ 
	rawData := json
]
