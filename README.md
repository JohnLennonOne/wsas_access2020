This repository provides the official Matlab implementation of the following paper:  
Weakly-Supervised Attribute Segmentation  
GUANGZHEN LIU1 AND ZHIWU LU2,3
1School of Information, Renmin University of China, Beijing 100872, China (e-mail: lgz_cr86@ruc.edu.cn)
2Beijing Key Laboratory of Big Data Management and Analysis Methods, Beijing 100872, China (e-mail: zhiwu.lu@gmail.com)
3Gaoling School of Artificial Intelligence, Renmin University of China, Beijing 100872, China
Corresponding author: Zhiwu Lu (e-mail: zhiwu.lu@gmail.com).
This work was supported in part by National Natural Science Foundation of China (61976220, 61832017, and 61573363), and Beijing
Outstanding Young Scientist Program (BJJWZYJH012019100020098).  

**ABSTRACT:** Semantic segmentation is a fundamental vision problem which aims to divide an image into
non-overlapped regions and then assign them with predefined object labels. Despite its latest development
(especially deep neural network-based), semantic segmentation is still far from comprehensive understand-ing of the visual world around us. For example, the obtained object labels are not fine-grained enough for
solving more complicated vision tasks such as fine-grained retrieval with multiple attribute-based queries
(e.g. the query ‘a bird’ along with the attribute ‘has wing color: grey’). In this paper, we thus choose to
study a more challenging vision problem called attribute segmentation, which aims to localize attributes
within the targeted object (e.g. bird) in a given image. Due to the high cost of collecting pixel-level attribute
annotations, we focus on weakly-supervised attribute segmentation (WSAS) that utilizes only image-level
attribute labels for model training. Note that this new WSAS problem degrades to the conventional weakly-supervised semantic segmentation (WSSS) problem when attribute labels are considered as object labels.
To overcome the attribute label noise caused by image-level weak supervision, we propose a novel sparse
learning method for solving the WSAS problem. Extensive experiments demonstrate that the proposed
WSAS method significantly outperforms the state-of-the-art WSSS and attribute localization methods.  

**Dependencies**  
Matlab  
liblinear  
