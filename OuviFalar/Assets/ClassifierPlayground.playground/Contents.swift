import Foundation
import CreateML

guard let trainingDataFileURL = Bundle.main.url(forResource: "tweets_tratados", withExtension: "json"),
let testingDataFileURL = Bundle.main.url(forResource: "testing_tweets_tratados", withExtension: "json") else {
    fatalError("Error! No resource files found!")
}
do {
    let trainingDataTable = try MLDataTable(contentsOf: trainingDataFileURL)
    let testingDataTable = try MLDataTable(contentsOf: testingDataFileURL)
    let intentClassifier = try MLTextClassifier(trainingData: trainingDataTable, textColumn: "text", labelColumn: "label")
    let trainingAccuracy = (1.0 - intentClassifier.trainingMetrics.classificationError) * 100
    let validationAccuracy = (1.0 - intentClassifier.validationMetrics.classificationError) * 100
    let evaluationMetrics = intentClassifier.evaluation(on: testingDataTable, textColumn: "text", labelColumn: "label")
    let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100
    print("Training accuracy: \(trainingAccuracy)")
    print("Validation accuracy: \(validationAccuracy)")
    print("Evaluation accuracy: \(evaluationAccuracy)")
    let metadata = MLModelMetadata(author: "Samuel Brasileiro", shortDescription: "A model trained to classify the intent of the tweet", version: "1.0")
    let modelFileURL = URL(fileURLWithPath: "/Users/samuelbrasileiro/Downloads/TweetIntentClassifier.mlmodel")

    try intentClassifier.write(to: modelFileURL, metadata: metadata)
} catch {
    print(error.localizedDescription)
}

do {
    let trainingDataTable = try MLDataTable(contentsOf: trainingDataFileURL)
    let testingDataTable = try MLDataTable(contentsOf: testingDataFileURL)
    let desinfoClassifier = try MLTextClassifier(trainingData: trainingDataTable, textColumn: "text", labelColumn: "desinfo")
    let trainingAccuracy = (1.0 - desinfoClassifier.trainingMetrics.classificationError) * 100
    let validationAccuracy = (1.0 - desinfoClassifier.validationMetrics.classificationError) * 100
    let evaluationMetrics = desinfoClassifier.evaluation(on: testingDataTable, textColumn: "text", labelColumn: "desinfo")
    let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100
    print("Training accuracy: \(trainingAccuracy)")
    print("Validation accuracy: \(validationAccuracy)")
    print("Evaluation accuracy: \(evaluationAccuracy)")
    let metadata = MLModelMetadata(author: "Samuel Brasileiro", shortDescription: "A model trained to classify the desinfo rate of the tweet", version: "1.0")
    let modelFileURL = URL(fileURLWithPath: "/Users/samuelbrasileiro/Downloads/TweetDesinfoClassifier.mlmodel")

    try desinfoClassifier.write(to: modelFileURL, metadata: metadata)
} catch {
    print(error.localizedDescription)
}
