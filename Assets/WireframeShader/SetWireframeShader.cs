/*
 * SetWireframeShader
 * 
 * Copyright(C) 2022 ㊥Maruchu
 * 
 * This software is released under the MIT License.
 * http://opensource.org/licenses/mit-license.php
 */




using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif



/// <summary>
/// 配下のレンダラーをワイヤーフレームにしてくれるスクリプト
/// </summary>
public class SetWireframeShader : MonoBehaviour
{
#if UNITY_EDITOR
    //初期化フラグ
    [HideInInspector]
    public bool initializedFlag = false;
#endif
    /// <summary>
    /// 初期化
    /// </summary>
    private void Awake()
    {
        Initialize();
    }
    /// <summary>
    /// 見た目をワイヤーフレームに変更する
    /// </summary>
    public void Initialize()
    {
        //マテリアルを取得
        Material tempMat = Resources.Load("WireframeShader") as Material;
        var rendArray = GetComponentsInChildren<Renderer>();
        foreach (var tempRenderer in rendArray)
        {
            //レンダラーの持っている全マテリアルを変更する
            var matArray = new Material[] { tempMat };
            if (Application.isPlaying)
            {
                tempRenderer.materials = matArray;
            }
            else
            {
                tempRenderer.sharedMaterials = matArray;
            }
        }
    }
}

#if UNITY_EDITOR
/// <summary>
/// Inspector表示用
/// </summary>
[CustomEditor(typeof(SetWireframeShader))]
public class SetWireframeShaderEditor : Editor
{
    /// <summary>
    /// Inspector表示用
    /// </summary>
    public override void OnInspectorGUI()
    {
        //元のスクリプトを取得
        SetWireframeShader targetScript = target as SetWireframeShader;
        //任意のタイミングで反映させる？                   あるいは最初の一回
        if (GUILayout.Button("ワイヤーフレーム再反映") || !targetScript.initializedFlag)
        {
            //初期化する
            targetScript.Initialize();
            targetScript.initializedFlag = true;
            //画面に反映
            SceneView.RepaintAll();
            EditorApplication.QueuePlayerLoopUpdate();
        }

        //親のGUI表示をそのままやる
        base.OnInspectorGUI();
    }
}
#endif
