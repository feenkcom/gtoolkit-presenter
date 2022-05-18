Class {
	#name : #GtPresenterSlidePreviewScaleChanged,
	#superclass : #Announcement,
	#instVars : [
		'previewScale'
	],
	#category : #'GToolkit-Presenter-Models - Events'
}

{ #category : #generated }
GtPresenterSlidePreviewScaleChanged >> previewScale [
	<objectGetter: #slide>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ previewScale
]

{ #category : #generated }
GtPresenterSlidePreviewScaleChanged >> previewScale: aPreviewScale [
	<objectSetter: #slide>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	previewScale := aPreviewScale
]
